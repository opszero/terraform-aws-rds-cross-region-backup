from chalice import Chalice, Rate
import logging
import boto3
import botocore
import datetime
import re
import os

app = Chalice(app_name='rds-cross-region-backup')
app.log.setLevel(logging.DEBUG)

def backup():
    source_region = os.environ['SOURCE_REGION']
    target_region = os.environ['TARGET_REGION']
    instances = os.environ['INSTANCES'].split(',')
    account = os.environ['ACCOUNT']
    target_kms_key_id = os.environ['TARGET_KMS_KEY_ID']

    app.log.debug("Starting RDS production snapshot copy from {} to {}".format(source_region, target_region))

    source = boto3.client('rds', region_name=source_region)

    for instance in instances:
        app.log.debug("Backing up {}".format(instance))

        # source_instances = source.describe_db_instances(DBInstanceIdentifier=instance)
        source_snaps = source.describe_db_snapshots(DBInstanceIdentifier=instance)['DBSnapshots']
        source_snap = sorted(source_snaps, key=byTimestamp, reverse=True)[0]['DBSnapshotIdentifier']
        source_snap_arn = 'arn:aws:rds:%s:%s:snapshot:%s' % (source_region, account, source_snap)
        target_snap_id = (re.sub('rds:', '', source_snap))
        app.log.debug('Will Copy %s to %s' % (source_snap_arn, target_snap_id))
        target = boto3.client('rds', region_name=target_region)

        try:
            response = target.copy_db_snapshot(
                KmsKeyId=target_kms_key_id,
                SourceDBSnapshotIdentifier=source_snap_arn,
                TargetDBSnapshotIdentifier=target_snap_id,
                CopyTags=True,
                SourceRegion=source_region)

            app.log.debug(response)
        except botocore.exceptions.ClientError as e:
            app.log.error("Could not issue copy command: %s" % e)

        return target.describe_db_snapshots(SnapshotType='manual', DBInstanceIdentifier=instance)['DBSnapshots']


@app.route('/')
def index():
    return backup()

def byTimestamp(snap):
    if 'SnapshotCreateTime' in snap:
        return datetime.datetime.isoformat(snap['SnapshotCreateTime'])
    else:
        return datetime.datetime.isoformat(datetime.datetime.now())

@app.schedule(Rate(5, unit=Rate.DAYS))
def handler(event):
    return backup()

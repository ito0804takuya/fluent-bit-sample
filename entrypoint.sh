echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION

ECS_CONTAINER_METADATA_URI=http://169.254.170.2/v3/d9b7d1b3d7834fdfa9d4e8d3d9570447-1672267185
ECS_CONTAINER_METADATA_EXCLUDE_URL=${ECS_CONTAINER_METADATA_URI##*/}
ECS_TASK_ID=${ECS_CONTAINER_METADATA_EXCLUDE_URL%%-*}

RAILS_ENV="staging"

touch /var/log/input/staging.log
touch /var/log/input/staging.log-2020

touch /var/log/output/${ECS_TASK_ID}_${RAILS_ENV}.log
chmod +x /var/log/output/${ECS_TASK_ID}_${RAILS_ENV}.log

touch /var/log/output/{${ECS_TASK_ID}_cron.log,${ECS_TASK_ID}_error.log}

# ECS_TASK_ID=${ECS_CONTAINER_METADATA_EXCLUDE_URL%%-*} exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
# ECS_TASK_ID=$ECS_TASK_ID /fluent-bit/bin/fluent-bit -d -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -c /fluent-bit/etc/fluent-bit.conf
# ECS_TASK_ID=$ECS_TASK_ID /fluent-bit/bin/fluent-bit -d -c /fluent-bit/etc/application.conf
ECS_TASK_ID=$ECS_TASK_ID exec /fluent-bit/bin/fluent-bit -d -c /fluent-bit/etc/application.conf
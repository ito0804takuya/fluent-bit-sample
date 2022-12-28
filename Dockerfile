FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:2.28.4

COPY application.conf ./fluent-bit/etc/application.conf

COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

# ECS_CONTAINER_METADATA_URI はコンテナ起動時に決まるはずなので、Dockerfile内ではムリ

# Railsのログconfで、ECS_CONTAINER_METADATA_URIの文字列操作+ディレクトリ作成+ファイル指定ができるかどうか確認する

# ENV ECS_CONTAINER_METADATA_URI http://169.254.170.2/v3/7db5ca1775bd411fb67e79c670607e29-1672267185
# # SHELL ["/bin/sh", "-c"]
# # RUN /bin/bash -c 'export ECS_CONTAINER_METADATA_EXCLUDE_URL="${ECS_CONTAINER_METADATA_URI##*/}"'

# # ENV ECS_CONTAINER_METADATA_EXCLUDE_URL ${ECS_CONTAINER_METADATA_URI##*/}
# # RUN export ECS_CONTAINER_METADATA_EXCLUDE_URL="${ECS_CONTAINER_METADATA_URI##*/}"
# # RUN export ECS_CONTAINER_METADATA_EXCLUDE_URL=${ECS_CONTAINER_METADATA_URI##*/}

# # これ怒られる
# ENV ECS_CONTAINER_METADATA_EXCLUDE_URL ${ECS_CONTAINER_METADATA_URI##*/}
# # ENV ECS_CONTAINER_METADATA_EXCLUDE_URL ${ECS_CONTAINER_METADATA_URI}
# # ENV ECS_CONTAINER_METADATA_EXCLUDE_URL hoge

# # RUN ECS_TASK_ID=${ECS_CONTAINER_METADATA_EXCLUDE_URL%%-*}
# # # RUN echo $ECS_TASK_ID
# # ENV ECS_TASK_ID2 $ECS_TASK_ID

# COPY bash-sample.sh /bash-sample.sh
# RUN chmod +x ./bash-sample.sh
# # # # RUN ./bash-sample.sh
# # # ENTRYPOINT ["./bash-sample.sh"]
# CMD ["./bash-sample.sh"]
# RUN chmod +x /etc/rc.d/rc.local
# RUN echo sh ./bash-sample.sh >> /etc/rc.local

# ENV HOGE hoge1

# ディレクトリとファイルの作成は必要

# Railsコンテナのログをマウントして置いておくためのディレクトリ作成
RUN mkdir -p /var/log/input
# RUN mkdir -p /var/log/output/$HOGE
RUN mkdir -p /var/log/output

# # Railsコンテナのログを受け取るためのファイル作成
# RUN touch /var/log/input/staging.log
# # RUN touch /var/log/output/$HOSTNAME/staging.log
# RUN touch /var/log/output/$HOGE/staging.log
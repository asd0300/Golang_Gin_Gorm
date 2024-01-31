# 使用 Nginx 官方镜像
FROM nginx:alpine

# 将 dist/ 目录中的文件复制到 Nginx 服务器的 HTML 目录
COPY nuxt3/dist /usr/share/nginx/html

# 用自定义的 Nginx 配置文件替换默认的配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口 80
EXPOSE 80

# 启动 Nginx 服务器
CMD ["nginx", "-g", "daemon off;"]
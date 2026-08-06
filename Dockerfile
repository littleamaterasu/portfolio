# ---- Unity WebGL build served bằng nginx ----
FROM nginx:1.27-alpine

# template này sẽ được entrypoint mặc định của image nginx tự động
# envsubst -> /etc/nginx/conf.d/default.conf khi container khởi động,
# thay ${PORT} bằng port thật mà Render cấp cho container
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# copy toàn bộ thư mục web build (index.html, Build/, TemplateData/, StreamingAssets/...)
COPY . /usr/share/nginx/html

# dọn các file hạ tầng lỡ bị copy theo, không cần public ra web
RUN rm -f /usr/share/nginx/html/Dockerfile \
           /usr/share/nginx/html/nginx.conf.template \
           /usr/share/nginx/html/.dockerignore

# Render sẽ tự set biến PORT khi chạy container, giá trị này chỉ là fallback
# khi chạy local không truyền PORT
ENV PORT=8080
EXPOSE 8080

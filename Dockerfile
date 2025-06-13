FROM rockylinux:9

#安装Cloudflare WARP packages和sing-box
RUN curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | tee /etc/yum.repos.d/cloudflare-warp.repo && dnf update -y && dnf install -y cloudflare-warp
RUN dnf install -y dnf-plugins-core && dnf config-manager --add-repo https://sing-box.app/sing-box.repo && dnf install -y sing-box

#注册启用cloudflare warp然后运行sing-box
CMD ["sh", "-c", "warp-cli registration new && warp-cli connect && curl https://www.cloudflare.com/cdn-cgi/trace/ && sing-box run -c /etc/sing-box/*.json"]

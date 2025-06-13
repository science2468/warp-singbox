FROM rockylinux:9

#安装Cloudflare WARP packages和sing-box
RUN dnf install -y curl && dnf clean all
RUN curl -fsSl https://pkg.cloudflareclient.com/cloudflare-warp-ascii.repo | sudo tee /etc/yum.repos.d/cloudflare-warp.repo && sudo yum update && sudo yum install cloudflare-warp
RUN sudo dnf config-manager --add-repo https://sing-box.app/sing-box.repo && sudo dnf -y install dnf-plugins-core && sudo dnf install sing-box

#注册启用cloudflare warp然后运行sing-box
CMD ["sh", "-c", "warp-cli registration new && warp-cli connect && curl https://www.cloudflare.com/cdn-cgi/trace/ && sing-box run -c /etc/sing-box/*.json"]

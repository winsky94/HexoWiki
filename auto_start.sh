source /etc/profile
source ~/bash_profile

cd /home/wiki

# webhook服务启动
/sbin/runuser -l root -c "pm2 start /home/wiki/webhooks.js"

# 启动博客
hexo s -p 4001 &

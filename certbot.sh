certbot --nginx --keep-until-expiring -m alexander_dx_10@hotmail.com --agree-tos -d mysql.syssoftintegra.com --redirect --no-eff-email

certbot --nginx --keep-until-expiring -m alexander_dx_10@hotmail.com --agree-tos -d laluz.syssoftintegra.com --redirect --no-eff-email

certbot --nginx --keep-until-expiring -m alexander_dx_10@hotmail.com --agree-tos -d tp.syssoftintegra.com --redirect --no-eff-email

certbot --nginx --keep-until-expiring -m alexander_dx_10@hotmail.com --agree-tos -d pj.syssoftintegra.com --redirect --no-eff-email

service nginx restart

tail -f /var/log/nginx/access.log
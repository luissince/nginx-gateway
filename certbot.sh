certbot --nginx --keep-until-expiring -m llara@mail.upla.edu.pe --agree-tos -d app.upla.edu.pe --redirect --no-eff-email

certbot --nginx --keep-until-expiring -m llara@mail.upla.edu.pe --agree-tos -d api.upla.edu.pe --redirect --no-eff-email

service nginx restart

tail -f /var/log/nginx/access.log

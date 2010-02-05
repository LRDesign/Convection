
Factory.define :preferences do |p|
  p.domain        "foobar.com"
  p.site_name     "Convection: File Exchange Made Easy"
  p.smtp_server   "smtp.example.com"
  p.smtp_port     25
  p.smtp_uses_tls false
  p.logo_url      "/images/convection_logo.png"      
  p.upload_notifications true
  p.admin_email   "admin@example.com"
end


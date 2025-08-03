
## 🚀 HƯỚNG DẪN BUILD VÀ DEPLOY

```bash
# Build project
mvn clean package

# Copy WAR file to Tomcat
copy target\mobile-shop.war "C:\Program Files\Apache Software Foundation\Tomcat 9.0\apache-tomcat-9.0.85\webapps\"

# Restart Tomcat (nếu cần)
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\apache-tomcat-9.0.85\bin"
shutdown.bat
startup.bat
```

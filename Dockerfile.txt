FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp
COPY WEB-INF /usr/local/tomcat/webapps/ROOT/WEB-INF

EXPOSE 8080

CMD ["catalina.sh", "run"]
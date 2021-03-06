{% from "tomcat/map.jinja" import tomcat with context %}
{% set tomcat_java_home = tomcat.java_home %}
{% set tomcat_java_opts = tomcat.java_opts %}

tomcat:
  pkg.installed:
    - name: {{ tomcat.pkg }}
    {% if tomcat.version is defined %}
    - version: {{ tomcat.version }}
    {% endif %}
  service.running:
    - name: {{ tomcat.service }}
    - enable: {{ tomcat.service_enabled }}
    - watch:
      - pkg: tomcat
# To install haveged in centos you need the EPEL repository
{% if tomcat.with_haveged %}
  require:
    - pkg: haveged

haveged:
  pkg.installed: []
  service.running:
    - enable: {{ tomcat.haveged_enabled }}
    - watch:
       - pkg: haveged
{% endif %}


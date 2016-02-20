{% from "supervisor/map.jinja" import supervisor with context %}

supervisor:
  pkg:
    - installed
    - name: {{ supervisor.pkg }}

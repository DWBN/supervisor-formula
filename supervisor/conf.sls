{% from "supervisor/map.jinja" import supervisor, supervisor_config with context %}

include:
  - supervisor

supervisor-dirs:
  file.directory:
    - names:
      - {{ supervisor.confdir }}
      - {{ supervisor.rundir }}
      - {{ supervisor.logdir }}
      - {{ supervisor.include_confdir }}
    - require:
      - pkg: supervisor

supervisor-config:
  file.managed:
    - name: {{ supervisor.conf_file }}
    - source: salt://supervisor/templates/conf.jinja
    - template: jinja
    - context:
      config: {{ supervisor_config }}
    - watch_in:
      - service: supervisor
      - cmd: supervisorctl-reread-reload
    - require:
      - file: supervisor-dirs

supervisorctl-reread:
  cmd.wait:
    - name: supervisorctl reread && supervisorctl reload

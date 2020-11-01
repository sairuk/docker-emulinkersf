# emulinkersf
Running emulinkersf in docker, read the Dockerfile for details, runs as an
unprivileged user on debian base 32b

### Build image
``` docker build -t emulinkersf .```

### Run
``` docker run -d --rm emulinkersf:latest ```

### Config
Override file structure for emulinksf under _custom

For example if you wanted to add custom configuration to the container and then
build the container

```
.
└── conf
    ├── access.cfg
    ├── emulinker.cfg
    └── language.properties

```

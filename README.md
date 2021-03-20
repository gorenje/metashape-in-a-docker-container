# Metashape in a Docker Container

An attempt to get [Metashape](https://www.agisoft.com) running in a container.

Metashape being software for doing [photogrammetry](https://en.wikipedia.org/wiki/Photogrammetry).

This is a **non-working** attempt of getting a Linux version of Metashape running in a Docker container. This was tested on a Mac and your mileage will vary.

## Prerequistics

Docker, Xquartz and Make.

### Xquartz

Start Xquartz and make the following [changes](https://www.sicpers.info/2020/10/running-linux-gui-apps-under-macos-using-docker/), i.e. allow network interaction with X11.

> First time through, open XQuartz, goto preferences > Security and check the option to allow connections from network clients, quit XQuartz.

Enable indirect OpenGL rendering in Xquartz, from [here](https://services.dartmouth.edu/TDClient/1806/Portal/KB/ArticleDet?ID=89669):

```
defaults write org.macosforge.xquartz.X11 enable_iglx -bool true
```

You might need to do that - depends on the Xquartz version. I was using `XQuartz 2.8.0_rc4 (xorg-server 1.19.7)`.

Restart Xquartz

In the terminal window that opens with Xquartz, type `xhost +` <-- allow all hosts to connect. WARNING: this is a security issue since it allows everyone and their dog to connect to your running X display.

So don't forget to switch of Xquartz after you have finished.

### Running & Failing

To build and run the container:

```
make run
```

That will attempt to start metashape but crashes (for me at least) with the following error:

```
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
QOpenGLWidget: Failed to make context current
QOpenGLShaderProgram: could not create shader program
QOpenGLShader: could not create shader
Could not link shader program:
 ""
Segmentation fault
```

Underlying issue does seem to be the shader.

### Diagnosis

Runnning the diagnosis image can perhaps help:

```
make run-diagnosis
```

Doing running `glxgears` in that container will in fact show the gears however running `strace glxgears` will actually show the gears turning! Very strange.

Running `glxinfo -B` shows:

```
name of display: host.docker.internal:0
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
display: host.docker.internal:0  screen: 0
direct rendering: No (If you want to find out why, try setting LIBGL_DEBUG=verbose)
OpenGL vendor string: Intel Inc.
OpenGL renderer string: Intel Iris Pro OpenGL Engine
OpenGL version string: 1.4 (2.1 INTEL-10.36.19)
```

I read somewhere that shaders are supported with OpenGL v2 and since my version is 1.4 - no shaders. But no idea.

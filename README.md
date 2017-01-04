# PokeGO-Tweak
This repository contains a proof-of-concept of a Mobile Substrate tweak which can be used to intercept, handle and tamper Pokemon GO data on-the-fly, directly on the device. <br>

Everything is packed inside an XCode project, so you can work from the IDE without additional setups. <br>

Requires a jailbroken iDevice (unless you side-load the tweak) and THEOS installed on your machine.

## Disclaimer
> All the source code on this repository is provided for educational and informational purpose only, and should not be construed as legal advice or as an offer to perform legal services on any subject matter.
> 
> The information is not guaranteed to be correct, complete or current. 
> 
> The author (Alexandro Luongo) makes no warranty (expressed or implied) about the accuracy or reliability of the information at this repository or at any other website to which it is linked.

## Compilation
The project comes with both the latest Google Protocol Buffers, and the compiled Pokemon GO proto messages. <br>

THEOS is required in order to build the source code: if you installed it in a custom directory, remember to define the new path inside the project build settings (under the voice named "THEOS").

## Features
The source code includes a couple of examples about request/response handling and tampering, but more features can be added inside the "Tweak.xm" file: follow the comments to understand the operations flow. <br>

Messages coming from the server can be edited without additional setups... messages going to the server, instead, require a working implementation of the latest hashing algorithm used from Niantic (not included here). <br>

![alt tag](http://i66.tinypic.com/2e0o853.png)

## References

| Project                 | Link                                    |
|-------------------------|-----------------------------------------|
| Google Protocol Buffers | https://github.com/google/protobuf      |
| POGOProtos              | https://github.com/AeonLucid/POGOProtos |

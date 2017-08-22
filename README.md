# PoGO-Tweak
This repository contains a proof-of-concept of a Man-in-the-Middle attack over the official Pokemon GO iOS client: it's a Mobile Substrate tweak which can be used to intercept, handle and tamper data on-the-fly, directly on the device. <br>

Everything is packed inside an XCode project, so you can work from the IDE without additional setups. <br>

Requires a jailbroken iDevice (~~~~unless you side-load the tweak~~~~) and THEOS installed on your machine.

## Updates:
* **Jan, 4th 2017:** First release
* **May, 6th 2017:** Updated after Niantic's recent attempt to stop MITM attacks ;)
* **Aug, 22th 2017:** Updated code and offsets for Pokemon GO v1.39.1

## Disclaimer
> All the source code on this repository is provided for educational and informational purpose only, and should not be construed as legal advice or as an offer to perform legal services on any subject matter.
> 
> The information is not guaranteed to be correct, complete or current. 
> 
> The author (Alexandro Luongo) makes no warranty (expressed or implied) about the accuracy or reliability of the information at this repository or at any other website to which it is linked.

## Features
The source code includes a couple of examples about request/response handling and tampering, but more features can be added inside the `Tweak.xm` file: follow the comments to understand the operations flow. <br>

Messages coming from the server can be edited without additional setups... messages going to the server ~~~~require a working implementation of the latest hashing algorithm used from Niantic~~~~ **too**.<br>

![alt tag](http://i63.tinypic.com/2h7i78l.png)
![alt tag](http://i66.tinypic.com/2e0o853.png)

## References

| Project                 | Link                                    |
|-------------------------|-----------------------------------------|
| THEOS                   | https://github.com/theos/theos          |
| POGOProtos              | https://github.com/AeonLucid/POGOProtos |
| Google Protocol Buffers | https://github.com/google/protobuf      |

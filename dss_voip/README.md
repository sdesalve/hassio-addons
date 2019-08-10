# SDeSalve Hass.io Add-ons: DSS VoIP Notifier

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[![Support my work on Paypal][paypal-shield]][paypal]

This add-on allows you to make VoIP calls from Hassio.

## Features

This add-on, of course, provides a way to transform a text in a audio file, make a VoIP call to a SIP url and play them to the attendee.
You will need a valid VoIP account and their parameters to customize this addon config.

Obviously you need to setup [Google Translate Text-to-Speech][googletts].
The google_translate text-to-speech platform uses unofficial Google Translate Text-to-Speech engine to read a text with natural sounding voices. 

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. Add my Hass.io add-ons repository (**https://github.com/sdesalve/hassio-addons**) to your Hass.io instance.
1. Install the "DSS VoIP Notifier" add-on.
1. Configure the `sip_server_uri`, `caller_id_uri`, `username`, and `password` options.
1. Start the "DSS VoIP Notifier" add-on.
1. Check the logs of the "DSS VoIP Notifier" add-on to see if everything
    went well. Addons will wait to be invoked from an `automation`/`script`.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

DSS VoIP Notifier add-on configuration:

```json
{
  "sip_parameters": {
    "caller_id_uri": "sip:username@sipserver.com",
    "realm": "*",
    "username": "username",
    "password": "password"
  }
}
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

#### Option `sip_parameters`: `callerd_id` (Required)

Set SIP URL of the account(i.e. From header). For example: "sip:username@sipserver.com"

#### Option `sip_parameters`: `username` (If required by outgooing server in **call_sip_uri**. See below.)

Set authentication user ID.

#### Option `sip_parameters`: `password` (If required by outgooing server in **call_sip_uri**. See below.)

Set authentication password (clear text).

#### Option `sip_parameters`: `realm` (Optional)

Set authentication realm. The realm is used to match this credential against challenges issued by downstream servers. If the realm is not known beforehand, wildcard character ('*') can be specified to make SIP Client respond to any realms.

## Example config for some VoIP providers

Pbxes.com phonebox
```json
{
  "sipparameters": {
    "caller_id_uri": "sip:extension@pbxes.com",
    "realm": "*",
    "username": "extension",
    "password": "password"
  }
}
```
**Note**: _call_sip_uri_ in Hassio service call must end with **@pbxes.com**. An example of URL: "sip:+393334455667@pbxes.com"

Vohippo.com VoIP provider
```json
{
  "sipparameters": {
    "caller_id_uri": "sip:username@sip.vohippo.com",
    "realm": "*",
    "username": "username",
    "password": "password"
  }
}
```
**Note**: _call_sip_uri_ in Hassio service call must end with **@vohippo.com**. An example of URL: "sip:+393334455667@vohippo.com"

Eutelia.it/CloudItaliaOrchestra.it  VoIP provider
```json
{
  "sipparameters": {
    "caller_id_uri": "sip:phonenumber@voip.eutelia.it",
    "realm": "*",
    "username": "phonenumber",
    "password": "password"
  }
}
```
**Note**: _call_sip_uri_ in Hassio service call must end with **@voip.eutelia.it**. An example of URL: "sip:+393334455667@voip.eutelia.it"

## How to use

You will need to call this addon from your Hassio `automation`/`script` usign following yaml service invoke:

```yaml
   ...
    - service: hassio.addon_stdin
      data_template:
        addon: 89275b70_dss_voip
        input: {"call_sip_uri":"sip:call_sip_uri@sipserver.com","message_tts":"Write here your message"}
   ...
```

#### Option `call_sip_uri` (Required)

Set SIP URL to call. For example: "sip:username@sipserver.com" or "sip:+393334455667@sipserver.com"
Outgooing SIP server can require authentication. Please set an `username` and `password` under `sip_parameters` section in addon config.

#### Option `message_tts` (Required)

Write here your message that will be played thru TTS to the attendee.


## Support

Got questions?

You have several options to get them answered:

- The [HassioHelp - Domotica Shelly Sonoff Xiaomi @hassiohelp][hassiohelp] a telegram Home Assistant Italian Group for add-on
  support and general Home Assistant discussions and questions.
- [Open an issue here][issue] GitHub.

![GATracking][gatracking]
![Clicky][clicky]

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [SDeSalve][sdesalve].

## License

MIT License

Copyright (c) 2017-2019 SDeSalve

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee]: https://www.buymeacoffee.com/sdesalve
[sdesalve]: https://github.com/sdesalve
[issue]: https://github.com/sdesalve/hassio-addons/issues
[paypal-shield]: https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif
[paypal]: https://paypal.me/SDeSalve
[repository]: https://github.com/sdesalve/hassio-addons
[hassiohelp]: https://t.me/HassioHelp
[googletts]: https://www.home-assistant.io/components/google_translate
[gatracking]: https://ssl.google-analytics.com/collect?v=1&t=event&ec=github&ea=view&t=event&tid=UA-145414045-1&z=1565415715&cid=5940b69c-91c9-9ba5-290b-beb31c9d76fb&dt=DSS%20VoIP%20Notifier%20-%20README&dp=/DSS%20VoIP%20Notifier%20-%20README
[clicky]: https://in.getclicky.com/101201638ns.gif
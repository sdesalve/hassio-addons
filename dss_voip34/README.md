# SDeSalve Hass.io Add-ons: DSS VoIP Notifier34

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee] [![Support my work on Paypal][paypal-shield]][paypal]

This add-on allows you to make VoIP calls from Hass.io.

## Features

This add-on provides a way to transform a text in a audio file, make a VoIP call to a SIP url and play them to the attendee.
You will need a valid VoIP account and their parameters to customize this addon config.

Obviously you need to setup [Google Translate Text-to-Speech][googletts].
The google_translate text-to-speech platform uses unofficial Google Translate Text-to-Speech engine to read a text with natural sounding voices. Ensure that Google TTS is activated on your Home Assistant configuration.yaml:
```yaml
# Text to speech
tts:
  - platform: google_translate
    service_name: google_translate_say
    language: 'it'
    ...
```

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. Add my Hass.io add-ons repository (**https://github.com/sdesalve/hassio-addons**) to your Hass.io instance.
1. Install the "DSS VoIP Notifier34" add-on.
1. Configure at least the `caller_id_uri`, `username`, and `password` options.
1. Start the "DSS VoIP Notifier34" add-on.
1. Check the logs of the "DSS VoIP Notifier34" add-on to see if everything
    went well. Addons will wait to be invoked from an `automation`/`script`.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

DSS VoIP Notifier34 add-on configuration:

```yaml
sip_parameters:
  caller_id_uri: 'sip:username@sipserver.com'
  realm: '*'
  username: 'username'
  password: 'password'
```
**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Basic options

#### Option `sip_parameters`: `caller_id_uri` (Required)

Set SIP URL of the caller account (i.e. From header). For example: "sip:username@sipserver.com"

#### Option `sip_parameters`: `username` (If required by outgooing server in **call_sip_uri**. See below.)

Set authentication user ID.

#### Option `sip_parameters`: `password` (If required by outgooing server in **call_sip_uri**. See below.)

Set authentication password (clear text).

#### Option `sip_parameters`: `realm` (Optional)

Set authentication realm. The realm is used to match this credential against challenges issued by downstream servers. If the realm is not known beforehand, wildcard character ('*') can be specified to make SIP Client respond to any realms.

### Advanced options
Following options are not required for a standard setup. Use them if you know what are you doing.

#### Option `sip_parameters`: `sip_server_uri` (Optional)

Set the URL of the registrar server. If set, addon will auto-answer to call and play a dummy audio so you can check system's status. An example of URL: "sip:sipserver.com"

#### Option `pjsua_custom_options` (Optional)

Set optional custom command's line options. For reference see [PJSua man page][pjsuaman].

#### Option `sox_custom_options_input_file` (Optional)

Set optional custom command's line options for input file. For reference see [SoX man page][soxman].

#### Option `sox_custom_options_output_file` (Optional)

Set optional custom command's line options for output file. For reference see [SoX man page][soxman].

#### Option `max_call_time` (Optional)

Set maximum call duration in seconds. Accept value between 10 and 120 seconds, but must be in single quotes. Default value if this option is not specified is 50 seconds.  If set to '-1' max_call_time is set to the length of the wav file being read.  This setting is to accommodate auto-answering systems like pagers and intercoms.  Be advised that many such systems will present insert a short beep at the start of the page.  It may be adventitious to pad some small amount of silence at that start of the wav file.  See `call_duration` below.
The timer starts working after a call is initiated and is not related to the call status.  

#### Option `platform_tts` (Optional)

Specify Text-to-speech platform to use. Default value if this option is not specified is [_google_translate_][google_tts].
For a list of available TTS integration please see [Hassio integrations][tts_integration]

## Example config for some VoIP providers

### A Fritz!Box with VoIP PBX
```yaml
sip_parameters:
  caller_id_uri: 'sip:username@fritz.box:5060'
  realm: '*'
  username: 'username'
  password: 'password'
pjsua_custom_options: '--ip-addr=RASPBERRY_IP_ADDRESS'
```

**Note**: _call_sip_uri_ in Hass.io service call must end with **@fritz.box:5060**. An example of URL: "sip:+393334455667@fritz.box:5060".

Please note that "pjsua_custom_options": "--ip-addr=_RASPBERRY_IP_ADDRESS_" is mandatory and you need to replace _RASPBERRY_IP_ADDRESS_ with your LAN Raspberry IP Address

### [Pbxes.com phonebox][pbxesurl]
```yaml
sip_parameters:
  caller_id_uri: 'sip:extension@pbxes.com'
  realm: '*'
  username: 'extension'
  password: 'password'

```
**Note**: _call_sip_uri_ in Hass.io service call must end with **@pbxes.com**. An example of URL: "sip:+393334455667@pbxes.com"

### [Vohippo.com VoIP provider][vohippourl]
```yaml
sip_parameters:
  caller_id_uri: 'sip:AAAAA12456aaaaaaaa@sip.vohippo.com'
  realm: '*'
  username: 'AAAAA12456aaaaaaaa'
  password: 'ABCDE123456789FGHI'
```
**Note**: _call_sip_uri_ in Hass.io service call must end with **@sip.vohippo.com**. An example of URL: "sip:+393334455667@sip.vohippo.com"

### [CloudItaliaOrchestra.it VoIP provider][clouditaliaurl]
```yaml
sip_parameters:
  caller_id_uri: 'sip:phonenumber@voip.eutelia.it'
  realm: '*'
  username: 'phonenumber'
  password: 'password'
```
**Note**: _call_sip_uri_ in Hass.io service call must end with **@voip.eutelia.it**. An example of URL: "sip:+393334455667@voip.eutelia.it"

### [3CX PBX][3cxurl]
```yaml
sip_parameters:
  caller_id_uri: 'sip:extension@domain.3cx.com.au'
  realm: '*'
  username: 'AuthenticationID'
  password: 'AuthenticationPassword'
```
**Note**: Use the Authentication ID and Password from the Extension settings for username and password, but the SIP extension number for the caller ID URI

### [Messagenet VoIP provider][messageneturl]
```yaml
sip_parameters:
  caller_id_uri: 'sip:numerointerno@sip.messagenet.it'
  realm: '*'
  username: 'numerointerno'
  password: 'password'
pjsua_custom_options: '--outbound=sip:sip.messagenet.it:5061;lr'
```
**Note**: _numerointerno_ is a personal ID (aka URI or Internal number) that you have received with a mail from Messagenet. Be aware: is not your Messagenet User ID that you use to login on Messagenet website.
_call_sip_uri_ in Hass.io service call must end with **@sip.messagenet.it**. An example of URL: "sip:+393334455667@sip.messagenet.it"

### [FreeVoipDeal][freevoipdeal]/Any other Dellmont/Betamax provider
```yaml
sip_parameters:
  caller_id_uri: 'sip:username_or_phonenumber@sip.freevoipdeal.com'
  realm: '*'
  username: 'username'
  password: 'password'
pjsua_custom_options: '--no-tcp'
```
**Note**: _call_sip_uri_ in Hass.io service call must end with **@sip.freevoipdeal.com**. An example of URL: "sip:+393334455667@sip.freevoipdeal.com". 
Option _username_or_phonenumber_ can be your FreeVoipDeal username or any of authorized numbers.
Please note that "pjsua_custom_options": "--no-tcp" is mandatory. Without it you'll get an 408 error:

```
pjsua_app.c ....Call 0 is DISCONNECTED [reason=408 (Request Timeout)]
```

For a list of all Dellmont/Betamax provider and for get price comparison, please visit [Voip-comparison.com][voipcomparison].

### [2talk][2talkurl]
2talk is a NZ based VoIP and internet provider. Getting it set up with this addon was easy.
```yaml
sip_parameters:
  caller_id_uri: 'sip:areacodeandnumber@2talk.co.nz:5060'
  realm: '*'
  username: areacodeandnumber
  password: secretpassword
  ```
Where areacodeandnumber is in the format 035556789 (03 is the area code, the phone number is 5556789). This is the same login you would use in connecting your VoIP phone to 2talk.


## How to use

You will need to call this addon from your Hass.io `automation`/`script` usign following yaml service invoke:

```yaml
   ...
    - service: hassio.addon_stdin
      data_template:
        addon: 89275b70_dss_voip34
        input: {"call_sip_uri":"sip:+393334455667@sipserver.com","message_tts":"Write here your message"}
   ...
```
**Note**: Make sure _call_sip_uri_ was a SIP URI and ends with your SIP server. See samples above for some VoIP providers config.
If you have to use special character in your JSON string, you can escape it using \ character.

See this list of special character used in JSON :
```
\b  Backspace (ascii code 08)
\f  Form feed (ascii code 0C)
\n  New line
\r  Carriage return
\t  Tab
\"  Double quote
\\  Backslash character
```

#### Option `call_sip_uri` (Required)

Set SIP URL to call. For example: "sip:username@sipserver.com" or "sip:+393334455667@sipserver.com"
Outgooing SIP server can require authentication. Please set an `username` and `password` under `sip_parameters` section in addon config.

**Note**: To call external PTSN numbers, use the number in the SIP URI accounting for your dialer settings. For example for 3CX you may use "sip:0412345678@domain.3cx.com.au" and this will call the PTSN number if accessible from your PBX / VoIP provider.

#### Option `message_tts` (Required if `audio_file_url` is not specified)

Write here your message that will be played thru TTS to the attendee. If this option is not specified, the add-on will check presence of `audio_file_url` option. If nor `message_tts` neither `audio_file_url` are specified an error will raise.

#### Option `audio_file_url` (Required if `message_tts` is not specified)

Write here a valid URL of a MP3 file that will be played to the attendee. If nor `message_tts` neither `audio_file_url` are specified an error will raise.

**Note**: The length of the audio file should not be longer than 2 minutes 20 seconds. Anything longer and PjSua would start breaking up the voice path after that time. The sound plays fine for the first 2 minutes and 20 seconds and then starts breaking up. With 2 minute audio files, however, the sound plays endlessly. 

#### Option `call_duration` (Optional)

Set maximum call duration in seconds. Be aware that timer starts running after a call is initiated and is not related to the call status. If this option is specified `max_call_time` will be overwrited for service invocation.  If set to '-1' this will set the call duration to the length of the wav file.  See `max_call_time` above.


## Support

Got questions?

You have several options to get them answered:

- The [HassioHelp - Domotica Shelly Sonoff Xiaomi @hassiohelp][hassiohelp] a telegram Home Assistant Italian Group for add-on
  support and general Home Assistant discussions and questions.
- [Open an issue here][issue] GitHub.

![GATracking][gatracking]

## Contributing

This is an active project. I'm always open to people who want to
use the code or contribute to it.

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [SDeSalve][sdesalve].

## License

Copyright (c) 2019 SDeSalve

See [LICENSE][license]

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
[license]: https://github.com/sdesalve/hassio-addons/blob/master/dss_voip34/LICENSE.md
[pjsuaman]: https://www.pjsip.org/pjsua.htm#cmdline
[soxman]: http://sox.sourceforge.net/sox.html
[pbxesurl]: https://www.pbxes.com
[vohippourl]:  https://www.vohippo.com/index.php?rid=102324
[clouditaliaurl]: https://orchestra.clouditalia.com
[messageneturl]: https://messagenet.com/it
[3cxurl]: https://www.3cx.com/
[voipcomparison]: http://www.voip-comparison.com/
[voipcomparison]: http://www.voip-comparison.com
[freevoipdeal]: https://www.freevoipdeal.com
[tts_integration]: https://www.home-assistant.io/integrations/#text-to-speech
[google_tts]: https://www.home-assistant.io/integrations/google_translate
[2talkurl]: https://www.2talk.co.nz/

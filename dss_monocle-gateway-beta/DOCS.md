
# SDeSalve Home Assistant Add-ons: DSS Monocle Gateway

## Prerequisites

You'll need an account and an API token on [Monocle Cam Portal](https://portal.monoclecam.com). 
Obviously you'll need a camera and it must be added to your profile.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. Add my Home Assistant add-ons repository (**https://github.com/sdesalve/hassio-addons**) to your Home Assistant instance.
1. Install the "DSS Monocle Gateway" add-on.
1. Configure the `monocle_token` option.
1. Start the "DSS Monocle Gateway" add-on.
1. Check the logs of the "DSS Monocle Gateway" add-on to see if everything
    went well. Ask your Alexa to show you your cam

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

DSS Monocle Gateway add-on configuration:

```yaml
monocle_token: 'your_very_long_token'
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Basic options

#### Option `monocle_token` (Required)

Set your API token generated on your [Monocle Cam Account page](https://portal.monoclecam.com/account 

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

## Trademark legal notice

This add-on is not created, developed, affiliated, supported, maintained or endorsed by **shadeBlue LLC**.
All product names, logos, brands, trademarks and registered trademarks are property of their respective owners. All company, product, and service names used are for identification purposes only.
Use of these names, logos, trademarks, and brands does not imply endorsement.

## Authors & contributors

The original setup of this repository is by [SDeSalve][sdesalve].

## License

Copyright (c) 2020 SDeSalve

See [LICENSE][license]

[sdesalve]: https://github.com/sdesalve
[issue]: https://github.com/sdesalve/hassio-addons/issues
[repository]: https://github.com/sdesalve/hassio-addons
[hassiohelp]: https://t.me/HassioHelp
[gatracking]: https://ssl.google-analytics.com/collect?v=1&t=event&ec=github&ea=view&t=event&tid=UA-145414045-1&z=1565415715&cid=5940b69c-91c9-9ba5-290b-beb31c9d76fb&dt=DSS%20Monocle%20Gateway%20-%20README&dp=/DSS%20Monocle%20Gateway%20-%20README
[license]: https://github.com/sdesalve/hassio-addons/blob/master/dss_monocle-gateway/LICENSE.md

#!/usr/bin/with-contenv bashio
# ==============================================================================
# SDeSalve HomeAssistant Addon: Monocle Gateway
# Monocle Gateway - www.monoclecam.com
# ==============================================================================

bashio::log.green "[Info] Starting addon..."

# Generate monocle.token
MONOCLE_TOKEN=$(bashio::config 'monocle_token | length')
if [ "$MONOCLE_TOKEN" -gt "0" ]; then
   MONOCLE_TOKEN_VALUE=$(bashio::config 'monocle_token')

   if [ "$MONOCLE_TOKEN_VALUE" = "-" ] || [ "$MONOCLE_TOKEN_VALUE" = "your_very_long_token" ] ; then 
      bashio::log.red "[Error] Invalid config. You'll neend an API Token. Please obtain on https://portal.monoclecam.com/account!"
      exit 1
   fi

   rm -f /etc/monocle/monocle.token
   echo "$MONOCLE_TOKEN_VALUE"   > /etc/monocle/monocle.token
   bashio::log.green "[Info] monocle.token file was successfully created..."
             
   bashio::log.green "[Info] Starting Monocle Gateway service..."
   /usr/local/bin/monocle-gateway
else
   bashio::log.red \
     '-----------------------------------------------------------'
   bashio::log.red '                Oops! Something went wrong.'
   bashio::log.red
   bashio::log.red ' monocle_token option is mandatory'
   bashio::log.red \
     '-----------------------------------------------------------'
fi  

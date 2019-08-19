#!/usr/bin/env bashio
set -e

mkdir -p /share/dss_voip
rm -f /share/dss_voip/dss_*
chmod -R 770 /share/dss_voip

echo ""                                                     > /share/dss_voip/dss_voip.log
echo ""                                                     > /share/dss_voip/dss_pjsua.conf
echo ""                                                     > /share/dss_voip/dss_pjsua_autoanswer.conf

CONFIG_PATH=/data/options.json
bashio::log.green "[Info] Starting addon..."

# Generate pjsua.conf
SIP_PARAMETERS=$(bashio::config 'sip_parameters | length')

if [ "$SIP_PARAMETERS" -gt "0" ]; then
   SIP_PARAMETERS_VALUE=$(bashio::config 'sip_parameters')
   echo "--null-audio"                                      > /share/dss_voip/dss_pjsua.conf
   echo "--auto-play"                                      >> /share/dss_voip/dss_pjsua.conf
   echo "--play-file /share/dss_voip/dss_message_tts.wav"  >> /share/dss_voip/dss_pjsua.conf
   echo "--duration 10"                                    >> /share/dss_voip/dss_pjsua.conf

   SIP_SERVER_URI=$(bashio::config 'sip_parameters.sip_server_uri | length')
   CALLER_ID_URI=$(bashio::config 'sip_parameters.caller_id_uri | length')
   REALM=$(bashio::config 'sip_parameters.realm | length')
   USERNAME=$(bashio::config 'sip_parameters.username | length')
   PASSWORD=$(bashio::config 'sip_parameters.password | length')
   PJSUA_CUSTOM_OPTIONS=$(bashio::config 'pjsua_custom_options | length')
   SOX_CUSTOM_OPTIONS=$(bashio::config 'sox_custom_options | length')
   
   if [ "$CALLER_ID_URI" -gt "0" ]; then 
      CALLER_ID_URI_VALUE=$(bashio::config 'sip_parameters.caller_id_uri')
      echo "--id $CALLER_ID_URI_VALUE"                     >> /share/dss_voip/dss_pjsua.conf
   fi
   if [ "$REALM" -gt "0" ]; then 
      REALM_VALUE=$(bashio::config 'sip_parameters.realm')
   else
      REALM_VALUE="*"
   fi
   echo "--realm $REALM_VALUE"                             >> /share/dss_voip/dss_pjsua.conf
   
   if [ "$USERNAME" -gt "0" ]; then 
      USERNAME_VALUE=$(bashio::config 'sip_parameters.username')
      echo "--username $USERNAME_VALUE"                    >> /share/dss_voip/dss_pjsua.conf
   fi
   if [ "$PASSWORD" -gt "0" ]; then 
      PASSWORD_VALUE=$(bashio::config 'sip_parameters.password')
      echo "--password $PASSWORD_VALUE"                    >> /share/dss_voip/dss_pjsua.conf
   fi
   
   if [ "$CALLER_ID_URI_VALUE" = "sip:username@sipserver.com" ] && [ "$USERNAME_VALUE" = "username" ] && [ "$PASSWORD_VALUE" = "password" ]; then 
      bashio::log.red '[Error] Invalid config. Customize it!'
      echo "[Error] Invalid config. Customize it!"         >> /share/dss_voip/dss_voip.log
      exit 1
   fi
   
   if [ "$SIP_SERVER_URI" -gt "0" ]; then 
      SIP_SERVER_URI_VALUE=$(bashio::config 'sip_parameters.sip_server_uri')
      # echo "--registrar $SIP_SERVER_URI_VALUE"             >> /share/dss_voip/dss_pjsua.conf

      bashio::log.green "[Info] Registering as SIP Client..."
      echo "--registrar $SIP_SERVER_URI_VALUE"              > /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--id $CALLER_ID_URI_VALUE"                     >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--realm $REALM_VALUE"                          >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--username $USERNAME_VALUE"                    >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--password $PASSWORD_VALUE"                    >> /share/dss_voip/dss_pjsua_autoanswer.conf

      echo "--local-port 0"                                >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--null-audio"                                  >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--auto-play"                                   >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--play-file /etc/dss_pjsua_autoanswer.wav"     >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--duration 10"                                 >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--auto-answer 200"                             >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--auto-loop"                                   >> /share/dss_voip/dss_pjsua_autoanswer.conf
      echo "--max-calls 5"                                 >> /share/dss_voip/dss_pjsua_autoanswer.conf

      screen -dmS pjsua pjsua --app-log-level=5 --log-level=5 --log-file '/share/dss_voip/dss_pjsua_autoanswer.log' --config-file '/share/dss_voip/dss_pjsua_autoanswer.conf'
      if [ $? -eq 0 ]; then
         bashio::log.magenta \
           '-----------------------------------------------------------'
         bashio::log.magenta "                  SIP Client registered."
         bashio::log.magenta
         bashio::log.magenta " Call <$CALLER_ID_URI_VALUE>/VoIP phone number to check system status."
         bashio::log.magenta " You'll find logs in dss_pjsua_autoanswer.log..."
         bashio::log.magenta \
           '-----------------------------------------------------------'
      else
         bashio::log.red \
           '-----------------------------------------------------------'
         bashio::log.red '                Oops! Something went wrong.'
         bashio::log.red
         bashio::log.red ' Cannot register SIP Client'
         bashio::log.red \
           '-----------------------------------------------------------'
      fi            
   fi

   if [ "$PJSUA_CUSTOM_OPTIONS" -gt "0" ]; then 
      PJSUA_CUSTOM_OPTIONS_VALUE=$(bashio::config 'pjsua_custom_options')
      echo "$PJSUA_CUSTOM_OPTIONS_VALUE"                   >> /share/dss_voip/dss_pjsua.conf
      bashio::log.yellow "PJSUA_CUSTOM_OPTIONS = '$PJSUA_CUSTOM_OPTIONS_VALUE'"
   fi
   
   if [ "$SOX_CUSTOM_OPTIONS" -gt "0" ]; then 
      SOX_CUSTOM_OPTIONS_VALUE=$(bashio::config 'custom_options')
      echo "SOX_CUSTOM_OPTIONS = '$SOX_CUSTOM_OPTIONS_VALUE'" >> /share/dss_voip/dss_voip.log
      bashio::log.yellow "SOX_CUSTOM_OPTIONS = '$SOX_CUSTOM_OPTIONS_VALUE'"
   else
      SOX_CUSTOM_OPTIONS_VALUE=""
   fi
   
   echo ""                                                 >> /share/dss_voip/dss_pjsua.conf
   echo "sip_parameters = '$SIP_PARAMETERS_VALUE'"         >> /share/dss_voip/dss_voip.log
   
else
   bashio::log.red \
     '-----------------------------------------------------------'
   bashio::log.red '                Oops! Something went wrong.'
   bashio::log.red
   bashio::log.red ' sip_parameters not specified.'
   bashio::log.red \
     '-----------------------------------------------------------'
   echo "sip_parameters not specified"                     >> /share/dss_voip/dss_voip.log
   exit 1
fi

echo ""                                                    >> /share/dss_voip/dss_voip.conf

# change perms on config files
chmod 660 /share/dss_voip/dss_*

bashio::log.green "[Info] Listening for messages via stdin service call..."
# listen for input
while read -r msg; do

   rm -f /share/dss_voip/dss_message_tts.*
   MAKECALL="1"
   # parse JSON
   bashio::log.green "[Info] Received messages ${msg}"
   echo "[Info] Received messages '${msg}'"                >> /share/dss_voip/dss_voip.log
   
   CALL_SIP_URI="$(echo "$msg" | jq --raw-output '.call_sip_uri | length')"
   if [ "$CALL_SIP_URI" -gt "0" ]; then
      CALL_SIP_URI_VALUE="$(echo "$msg" | jq --raw-output '.call_sip_uri')"
      # bashio::log.info '[Debug] CALL_SIP_URI_VALUE = '$CALL_SIP_URI_VALUE 
      echo "CALL_SIP_URI_VALUE = '$CALL_SIP_URI_VALUE'"    >> /share/dss_voip/dss_voip.log
   else
      MAKECALL="0"
      bashio::log.red \
        '-----------------------------------------------------------'
      bashio::log.red '                Oops! Something went wrong.'
      bashio::log.red
      bashio::log.red ' call_sip_uri not specified.'
      bashio::log.red \
        '-----------------------------------------------------------'
      echo "call_sip_uri not specified"                    >> /share/dss_voip/dss_voip.log
   fi

   MESSAGE_TTS="$(echo "$msg" | jq --raw-output '.message_tts | length')"
   if [ "$MESSAGE_TTS" -gt "0" ]; then
      MESSAGE_TTS_VALUE="$(echo "$msg" | jq --raw-output '.message_tts')"
      # bashio::log.green '[Debug] MESSAGE_TTS_VALUE = '$MESSAGE_TTS_VALUE 
      echo "MESSAGE_TTS_VALUE = '$MESSAGE_TTS_VALUE'"      >> /share/dss_voip/dss_voip.log
   else
      MAKECALL="0"
      bashio::log.red \
        '-----------------------------------------------------------'
      bashio::log.red '                Oops! Something went wrong.'
      bashio::log.red
      bashio::log.red ' message_tts not specified.'
      bashio::log.red \
        '-----------------------------------------------------------'
      echo "message_tts not specified"                     >> /share/dss_voip/dss_voip.log
   fi
   
   if [ "$MAKECALL" -eq "1" ]; then
      DATA_JSON=$( jq --arg key0   'message' \
         --arg value0 ''"$MESSAGE_TTS_VALUE"'' \
         --arg key1   'platform' \
         --arg value1 'google_translate' \
         '. | .[$key0]=$value0 | .[$key1]=$value1' \
         <<<'{}')
      # bashio::log.info 'DATA_JSON = '$DATA_JSON 
      echo "DATA_JSON = '$DATA_JSON'"                      >> /share/dss_voip/dss_voip.log

      # bashio::log.green 'HASSIO_TOKEN = '$HASSIO_TOKEN 
      JSONGOOGLETTS=$( curl --silent -X POST -H "x-ha-access: ${HASSIO_TOKEN}" -H "Content-Type: application/json" -d "${DATA_JSON}" http://hassio/homeassistant/api/tts_get_url)
      echo "JSONGOOGLETTS = '$JSONGOOGLETTS'"              >> /share/dss_voip/dss_voip.log

      URLFILEMP3=$(echo "$JSONGOOGLETTS" | jq --raw-output ".url | length" )
      # cat /share/dss_voip/dss_pjsua.conf

      if [ "$URLFILEMP3" -gt "0" ]; then
         URLFILEMP3_VALUE=$(echo "$JSONGOOGLETTS" | jq --raw-output ".url" )
         echo "URLFILEMP3_VALUE = '$URLFILEMP3_VALUE'"     >> /share/dss_voip/dss_voip.log
         # bashio::log.green '[Debug] URLFILEMP3_VALUE = '$URLFILEMP3_VALUE 
         bashio::log.green "Converting audio file '$URLFILEMP3_VALUE'..."
         sox -V3 $SOX_CUSTOM_OPTIONS_VALUE $URLFILEMP3_VALUE /share/dss_voip/dss_message_tts.wav pad 0.5 1.5 2> /share/dss_voip/dss_sox.log
         if [ $? -eq 0 ]; then
            bashio::log.green "Audio succesfully converted..."
            bashio::log.green "Starting SIP Client and calling '$CALL_SIP_URI_VALUE'..."

            # n=0
            # while [ "$n" -lt 6 ] && [ -f '/share/dss_voip/current_call_data.log' ]; do
              # n=$(( n + 1 ))
              # sleep 5
              # bashio::log.yellow 'Another call is in progress... Please wait'
            # done
            
            # if [ -f '/share/dss_voip/current_call_data.log' ]; then
               # rm -f '/share/dss_voip/current_call_data.log'
               # bashio::log.red "Forcing this call... Other call's timeout has expired!"
            # fi
            # echo "Calling '$CALL_SIP_URI_VALUE'..."        > /share/dss_voip/current_call_data.log

            ( sleep 20; echo q ) | ( pjsua --app-log-level=3 --config-file '/share/dss_voip/dss_pjsua.conf' $CALL_SIP_URI_VALUE 2> /share/dss_voip/dss_pjsua.log) 
            if [ $? -eq 0 ]; then
               bashio::log.green "Call ended..."
            else
               bashio::log.red \
                 '-----------------------------------------------------------'
               bashio::log.red '                Oops! Something went wrong.'
               bashio::log.red
               bashio::log.red ' Cannot place this call'
               bashio::log.red \
                 '-----------------------------------------------------------'
            fi
            # rm -f '/share/dss_voip/current_call_data.log'
         else
            bashio::log.red \
              '-----------------------------------------------------------'
            bashio::log.red '                Oops! Something went wrong.'
            bashio::log.red
            bashio::log.red ' Cannot convert audio to .wav'
            bashio::log.red \
              '-----------------------------------------------------------'
         fi            
      else
         bashio::log.green '[Debug] JSONGOOGLETTS = '$JSONGOOGLETTS 
         bashio::log.red \
           '-----------------------------------------------------------'
         bashio::log.red '                Oops! Something went wrong.'
         bashio::log.red
         bashio::log.red ' Cannot get audio file:' "$JSONGOOGLETTS"
         bashio::log.red \
           '-----------------------------------------------------------'
      fi
   
   else
      bashio::log.red \
        '-----------------------------------------------------------'
      bashio::log.red '                Oops! Something went wrong.'
      bashio::log.red
      bashio::log.red ' Cannot make call'
      bashio::log.red \
        '-----------------------------------------------------------'
   fi
   
done

chmod -R 770 /share/dss_voip

#!/bin/bash
PUBLICKEY="yuxaotdj"
PRIVATEKEY="52f3f4a5-ca87-4e21-918f-eb1b7475cb72"
GROUPID="5c3dac79d5ec139867026e82"


# REPLICATION OPLOG
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '
       {
         "eventTypeName" : "REPLICATION_OPLOG_WINDOW_RUNNING_OUT",
         "enabled" : true,
         "notifications" : [ {
           "delayMin" : 0,
           "emailEnabled" : true,
           "intervalMin" : 60,
           "roles" : [ "GROUP_OWNER" ],
           "smsEnabled" : false,
           "typeName" : "GROUP"
         } ],
         "threshold" : {
           "operator" : "LESS_THAN",
           "threshold" : 1,
           "units" : "HOURS"
         },
         "typeName" : "REPLICA_SET"
       }'


# NEW PRIMARY
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
         "eventTypeName" : "PRIMARY_ELECTED",
         "enabled" : true,
         "notifications" : [ {
           "delayMin" : 0,
           "emailEnabled" : true,
           "intervalMin" : 60,
           "roles" : [ "GROUP_OWNER" ],
           "smsEnabled" : false,
           "typeName" : "GROUP"
         } ],
         "typeName" : "REPLICA_SET"
       }'


# PAGE FAULTS
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 10,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "metricThreshold":{  
      "metricName":"EXTRA_INFO_PAGE_FAULTS",
      "mode":"AVERAGE",
      "operator":"GREATER_THAN",
      "threshold":10.0,
      "units":"RAW"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'       

# QUEUES
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 5,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "metricThreshold":{  
      "metricName":"GLOBAL_LOCK_CURRENT_QUEUE_TOTAL",
      "mode":"AVERAGE",
      "operator":"GREATER_THAN",
      "threshold":50.0,
      "units":"RAW"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'  

# TOO MANY ELECTIONS
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "TOO_MANY_ELECTIONS",
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "threshold": {
                "operator": "GREATER_THAN",
                "threshold": 5
            },
            "typeName": "REPLICA_SET"
       }'


#REPLICA SET HAS NO PRIMARY
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "NO_PRIMARY",
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "REPLICA_SET"
        }'


#HOST DOWN
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "HOST_DOWN",
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST"
        }'

#######
#TICKETS AVAILABLE WARN AND ALERT
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '
        {
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "TICKETS_AVAILABLE_READS",
                "mode": "AVERAGE",
                "operator": "LESS_THAN",
                "threshold": 50.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "TICKETS_AVAILABLE_WRITES",
                "mode": "AVERAGE",
                "operator": "LESS_THAN",
                "threshold": 50.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'
        
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "TICKETS_AVAILABLE_READS",
                "mode": "AVERAGE",
                "operator": "LESS_THAN",
                "threshold": 100.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 2,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "TICKETS_AVAILABLE_WRITES",
                "mode": "AVERAGE",
                "operator": "LESS_THAN",
                "threshold": 100.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 2,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'



#CONNECTIONS 
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "CONNECTIONS",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 1000.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 1,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'

# QUERIES PERFORMANCES ABOVE 100 MS
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "AVG_READ_EXECUTION_TIME",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 100.0,
                "units": "MILLISECONDS"
            },
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'


# DISK LATENCY above 50ms for 1 minute
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "DISK_PARTITION_READ_LATENCY_DATA",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 50.0,
                "units": "MILLISECONDS"
            },
            "notifications": [
                {
                    "delayMin": 1,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'


# DISK SPACE USED > 90%
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "DISK_PARTITION_SPACE_USED_DATA",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 90.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'



# PAGE FAULTS 10+ for 1 minute
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "EXTRA_INFO_PAGE_FAULTS",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 10.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 1,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'

# REPLICATION HEADROOM BELOW 1 HOUR        
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "OPLOG_MASTER_LAG_TIME_DIFF",
                "mode": "AVERAGE",
                "operator": "LESS_THAN",
                "threshold": 1.0,
                "units": "HOURS"
            },
            "notifications": [
                {
                    "delayMin": 0,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'

# QUERY TARGETING SCANNED OBJECTS more than 500 in a minute
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "QUERY_TARGETING_SCANNED_OBJECTS_PER_RETURNED",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 500.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 1,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'

#  REPLICATION LAG
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "OPLOG_SLAVE_LAG_MASTER_TIME",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 20.0,
                "units": "SECONDS"
            },
            "notifications": [
                {
                    "delayMin": 1,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'



# CPU AND MEMORY PRESSURE, if both alerted, the cluster is about to be scaled out
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "SYSTEM_MEMORY_PERCENT_USED",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 75.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 60,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'
        
curl --user "$PUBLICKEY:$PRIVATEKEY" --digest \
     --request POST "https://cloud.mongodb.com/api/atlas/v1.0/groups/$GROUPID/alertConfigs" \
     --header "Content-Type: application/json" \
     --data '{
            "enabled": true,
            "eventTypeName": "OUTSIDE_METRIC_THRESHOLD",
            "metricThreshold": {
                "metricName": "NORMALIZED_SYSTEM_CPU_USER",
                "mode": "AVERAGE",
                "operator": "GREATER_THAN",
                "threshold": 75.0,
                "units": "RAW"
            },
            "notifications": [
                {
                    "delayMin": 60,
                    "emailEnabled": true,
                    "intervalMin": 60,
                    "smsEnabled": false,
                    "typeName": "GROUP"
                }
            ],
            "typeName": "HOST_METRIC"
        }'

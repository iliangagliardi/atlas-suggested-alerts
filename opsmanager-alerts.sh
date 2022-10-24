#!/bin/bash

HOST=http://hostname:8080
PUBLIC_API_KEY=
PRIVATE_API_KEY=

# Backup oplog behind
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "OPLOG_BEHIND",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "ADMIN"
        }
      ],
   "tags" : [ ],
   "typeName": "BACKUP"
}'

# No primary for 10 minutes or more
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "NO_PRIMARY",
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
   "tags" : [ ],
   "typeName": "REPLICA_SET"
}'

# Primary elected
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "PRIMARY_ELECTED",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "tags" : [ ],
   "typeName": "REPLICA_SET"
}'

# Host is down
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "HOST_DOWN",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "tags" : [ ],
   "typeName": "HOST"
}'

# Host is recovering for 10 minutes or more
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "HOST_RECOVERING",
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
   "tags" : [ ],
   "typeName": "HOST"
}'

# More than 80% disk space is used for the data partition
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "metricThreshold":{  
      "metricName":"DISK_PARTITION_SPACE_USED_DATA",
      "mode":"AVERAGE",
      "operator":"GREATER_THAN",
      "threshold":80.0,
      "units":"RAW"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'

# More than 10 page faults per sec (swapping) for 5 minutes or more
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
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

# More than 100 queued ops/sec for longer than 10 minutes
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
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
      "threshold":100.0,
      "units":"RAW"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'

# oplog window is less than 48 hours
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
   "eventTypeName" : "OUTSIDE_METRIC_THRESHOLD",
   "enabled" : true,
   "forAllGroups" : true,
   "groupIds" : [ ],
   "notifications" : [
        {
          "delayMin": 0,
          "emailEnabled": true,
          "intervalMin": 60,
          "smsEnabled": false,
          "typeName": "GROUP"
        }
      ],
   "metricThreshold":{  
      "metricName":"OPLOG_MASTER_TIME",
      "mode":"AVERAGE",
      "operator":"LESS_THAN",
      "threshold":48.0,
      "units":"HOURS"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'

# replication lag higher than 5 minutes for longer than 10 minutes
curl -i -u "$PUBLIC_API_KEY:$PRIVATE_API_KEY" --digest -H "Content-Type: application/json" -X POST "$HOST/api/public/v1.0/globalAlertConfigs" --data '
 {
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
      "metricName":"OPLOG_SLAVE_LAG_MASTER_TIME",
      "mode":"AVERAGE",
      "operator":"GREATER_THAN",
      "threshold":300.0,
      "units":"SECONDS"
   },
   "tags" : [ ],
   "typeName": "HOST_METRIC"
}'

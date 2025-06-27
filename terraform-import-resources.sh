#!/bin/bash

terraform import google_compute_instance.web_server html-server

terraform import google_compute_firewall.default-allow-http allow-http
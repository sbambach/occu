#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr dev_descr

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    psDescr
  upvar PROFILE_1     PROFILE_1

  set chn [getChannel $special_input_id]
  # Firmware = x.y.z
  # devFwMajor = x
  set devFwMajor [expr [lindex [split $dev_descr(FIRMWARE) .] 0] * 1]

  if {$devFwMajor > 1} {
    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
       set prn 0
       append HTML_PARAMS(separate_1) "[getKeyTransceiver $chn ps psDescr]";
    append HTML_PARAMS(separate_1) "</table>"
  } else {
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    set param LONG_PRESS_TIME
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableCentralKeyLongPressTime}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_InputElem $param separate_${special_input_id}_$prn ps $param]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"
  }

}

constructor
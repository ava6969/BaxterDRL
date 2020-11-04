// Auto-generated. Do not edit!

// (in-package drl_project.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SetTorqueRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.t_value = null;
      this.g_value = null;
    }
    else {
      if (initObj.hasOwnProperty('t_value')) {
        this.t_value = initObj.t_value
      }
      else {
        this.t_value = [];
      }
      if (initObj.hasOwnProperty('g_value')) {
        this.g_value = initObj.g_value
      }
      else {
        this.g_value = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetTorqueRequest
    // Serialize message field [t_value]
    bufferOffset = _arraySerializer.float64(obj.t_value, buffer, bufferOffset, null);
    // Serialize message field [g_value]
    bufferOffset = _serializer.float64(obj.g_value, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTorqueRequest
    let len;
    let data = new SetTorqueRequest(null);
    // Deserialize message field [t_value]
    data.t_value = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [g_value]
    data.g_value = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.t_value.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/SetTorqueRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a50b48b6ae6e4ba807756e2843deb824';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] t_value
    float64 g_value
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetTorqueRequest(null);
    if (msg.t_value !== undefined) {
      resolved.t_value = msg.t_value;
    }
    else {
      resolved.t_value = []
    }

    if (msg.g_value !== undefined) {
      resolved.g_value = msg.g_value;
    }
    else {
      resolved.g_value = 0.0
    }

    return resolved;
    }
};

class SetTorqueResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SetTorqueResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SetTorqueResponse
    let len;
    let data = new SetTorqueResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/SetTorqueResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SetTorqueResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: SetTorqueRequest,
  Response: SetTorqueResponse,
  md5sum() { return 'a50b48b6ae6e4ba807756e2843deb824'; },
  datatype() { return 'drl_project/SetTorque'; }
};

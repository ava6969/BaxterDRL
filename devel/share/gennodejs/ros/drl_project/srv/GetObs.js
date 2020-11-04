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

class GetObsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetObsRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetObsRequest
    let len;
    let data = new GetObsRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/GetObsRequest';
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
    const resolved = new GetObsRequest(null);
    return resolved;
    }
};

class GetObsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.obs = null;
    }
    else {
      if (initObj.hasOwnProperty('obs')) {
        this.obs = initObj.obs
      }
      else {
        this.obs = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetObsResponse
    // Serialize message field [obs]
    bufferOffset = _arraySerializer.float64(obj.obs, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetObsResponse
    let len;
    let data = new GetObsResponse(null);
    // Deserialize message field [obs]
    data.obs = _arrayDeserializer.float64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.obs.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/GetObsResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '8dac64abe4f5eba5d19614ccef1fe66c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] obs
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetObsResponse(null);
    if (msg.obs !== undefined) {
      resolved.obs = msg.obs;
    }
    else {
      resolved.obs = []
    }

    return resolved;
    }
};

module.exports = {
  Request: GetObsRequest,
  Response: GetObsResponse,
  md5sum() { return '8dac64abe4f5eba5d19614ccef1fe66c'; },
  datatype() { return 'drl_project/GetObs'; }
};

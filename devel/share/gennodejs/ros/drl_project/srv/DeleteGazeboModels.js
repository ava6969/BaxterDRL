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

class DeleteGazeboModelsRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.only_blocks = null;
    }
    else {
      if (initObj.hasOwnProperty('only_blocks')) {
        this.only_blocks = initObj.only_blocks
      }
      else {
        this.only_blocks = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DeleteGazeboModelsRequest
    // Serialize message field [only_blocks]
    bufferOffset = _serializer.bool(obj.only_blocks, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DeleteGazeboModelsRequest
    let len;
    let data = new DeleteGazeboModelsRequest(null);
    // Deserialize message field [only_blocks]
    data.only_blocks = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/DeleteGazeboModelsRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'b129c2666f54b5803dca2de530a0d745';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool only_blocks
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DeleteGazeboModelsRequest(null);
    if (msg.only_blocks !== undefined) {
      resolved.only_blocks = msg.only_blocks;
    }
    else {
      resolved.only_blocks = false
    }

    return resolved;
    }
};

class DeleteGazeboModelsResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DeleteGazeboModelsResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DeleteGazeboModelsResponse
    let len;
    let data = new DeleteGazeboModelsResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/DeleteGazeboModelsResponse';
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
    const resolved = new DeleteGazeboModelsResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: DeleteGazeboModelsRequest,
  Response: DeleteGazeboModelsResponse,
  md5sum() { return 'b129c2666f54b5803dca2de530a0d745'; },
  datatype() { return 'drl_project/DeleteGazeboModels'; }
};

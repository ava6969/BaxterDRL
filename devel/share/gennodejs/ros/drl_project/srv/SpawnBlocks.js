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

class SpawnBlocksRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.block_pose = null;
      this.block_reference_frame = null;
    }
    else {
      if (initObj.hasOwnProperty('block_pose')) {
        this.block_pose = initObj.block_pose
      }
      else {
        this.block_pose = [];
      }
      if (initObj.hasOwnProperty('block_reference_frame')) {
        this.block_reference_frame = initObj.block_reference_frame
      }
      else {
        this.block_reference_frame = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpawnBlocksRequest
    // Serialize message field [block_pose]
    bufferOffset = _arraySerializer.float64(obj.block_pose, buffer, bufferOffset, null);
    // Serialize message field [block_reference_frame]
    bufferOffset = _serializer.string(obj.block_reference_frame, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpawnBlocksRequest
    let len;
    let data = new SpawnBlocksRequest(null);
    // Deserialize message field [block_pose]
    data.block_pose = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [block_reference_frame]
    data.block_reference_frame = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.block_pose.length;
    length += object.block_reference_frame.length;
    return length + 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/SpawnBlocksRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3a354f469531ae7418e2e3001fc52e12';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float64[] block_pose
    string block_reference_frame
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SpawnBlocksRequest(null);
    if (msg.block_pose !== undefined) {
      resolved.block_pose = msg.block_pose;
    }
    else {
      resolved.block_pose = []
    }

    if (msg.block_reference_frame !== undefined) {
      resolved.block_reference_frame = msg.block_reference_frame;
    }
    else {
      resolved.block_reference_frame = ''
    }

    return resolved;
    }
};

class SpawnBlocksResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SpawnBlocksResponse
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SpawnBlocksResponse
    let len;
    let data = new SpawnBlocksResponse(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'drl_project/SpawnBlocksResponse';
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
    const resolved = new SpawnBlocksResponse(null);
    return resolved;
    }
};

module.exports = {
  Request: SpawnBlocksRequest,
  Response: SpawnBlocksResponse,
  md5sum() { return '3a354f469531ae7418e2e3001fc52e12'; },
  datatype() { return 'drl_project/SpawnBlocks'; }
};

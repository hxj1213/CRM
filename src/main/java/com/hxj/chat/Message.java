package com.hxj.chat;


import java.io.Serializable;

/**
 * Created by hxj on 17-8-24.
 */
public class Message implements Serializable {

    /*
    *   0 : 上线消息   上线时获取用户名存储在列表中
    *   1 : 聊天消息   正常收发
    * */
    private int msgType;
    private String userName;
    private String message;
    private String toUser;

    public Message(){}

    public Message(int msgType, String userName, String message, String toUser) {
        this.msgType = msgType;
        this.userName = userName;
        this.message = message;
        this.toUser = toUser;
    }

    public int getMsgType() {
        return msgType;
    }

    public String getUserName() {
        return userName;
    }

    public String getMessage() {
        return message;
    }

    public String getToUser() {
        return toUser;
    }

    public void setMsgType(int msgType) {
        this.msgType = msgType;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    @Override
    public String toString() {
        return "Message{" +
                "msgType=" + msgType +
                ", userName='" + userName + '\'' +
                ", message='" + message + '\'' +
                ", toUser='" + toUser + '\'' +
                '}';
    }
}

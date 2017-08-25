package com.hxj.chat;

import com.hxj.chat.util.JsonUtil;
import org.springframework.jdbc.support.JdbcUtils;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;

/**
 * Created by hxj on 17-8-24.
 */
@ServerEndpoint("/init")
public class ChatServer {

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("---------onOpen----------"+session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws IOException {
        System.out.println("-----onMessage------"+message+"     "+session);
        Message msg = JsonUtil.getBean(message,Message.class);
        int type = msg.getMsgType();
        switch (type){
            case 0:
                //上线消息
                UserPool.add(msg.getUserName(),session);
                System.out.println(UserPool.getUserPool());
                Session toSession = UserPool.get(msg.getToUser());
                System.out.println("toSession:"+toSession);

                if(toSession==null || !toSession.isOpen()) {
                    UserPool.remove(msg.getToUser());
                    try {
                        Message newMsg = new Message(3,"","您访问的用户不在线","");
                        session.getBasicRemote().sendText(JsonUtil.getString(newMsg));
                    }catch (IOException e){
                        e.printStackTrace();
                    }
                    break;
                }else{
                    try {
                        msg.setMessage(msg.getMessage());
                        toSession.getBasicRemote().sendText(JsonUtil.getString(msg));
                    }catch (IOException e){
                        e.printStackTrace();
                    }
                }

                break;
            case 1:
                //私聊消息
                Session toSession1 = UserPool.get(msg.getToUser());
                if(!toSession1.isOpen()) {
                    UserPool.remove(msg.getToUser());
                    break;
                }
                try {
                    msg.setMessage(msg.getMessage());
                    toSession1.getBasicRemote().sendText(JsonUtil.getString(msg));
                }catch (IOException e){
                    e.printStackTrace();
                }
                break;
            case 2:
                UserPool.remove(msg.getUserName());
                break;
        }
    }

    @OnError
    public void onError(Throwable throwable) {
        System.out.println("--------onError---------"+throwable);
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("--------onClose--------"+session);
    }

}

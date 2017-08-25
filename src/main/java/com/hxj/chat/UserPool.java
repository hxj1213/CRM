package com.hxj.chat;

import javax.websocket.Session;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by hxj on 17-8-24.
 */
public class UserPool {

    private static Map<String,Session> USER_POOL = new HashMap<>();

    public static void add(String nickName,Session session){
        USER_POOL.put(nickName,session);
    }

    public static Session get(String nickName){
       return USER_POOL.get(nickName);
    }

    public static void remove(String nickName){
        USER_POOL.remove(nickName);
    }

    public static Map<String, Session> getUserPool() {
        return USER_POOL;
    }

}

package com.n3.childrentoyweb.services;

import com.n3.childrentoyweb.dto.DelayCacheItemDTO;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.DelayQueue;

public class CacheService {
    private static CacheService instance;

    private Map<String, String> cacheMap = new ConcurrentHashMap<>();
    private DelayQueue<DelayCacheItemDTO> delayQueue = new DelayQueue<>();

    private CacheService() {
        Thread cleanupThread = new Thread(() -> {
           while (!Thread.currentThread().isInterrupted()) {
               try {
                    DelayCacheItemDTO itemDTO = delayQueue.take();
                    cacheMap.remove(itemDTO.getKey());
               } catch (InterruptedException e) {
                   Thread.currentThread().interrupt();
               }
           }
        });
        cleanupThread.setDaemon(true);
        cleanupThread.start();
    }

    public static synchronized CacheService getInstance() {
        if (instance == null) {
            instance = new CacheService();
        }
        return instance;
    }

    public void add(String email, String otp) {
        cacheMap.put(email, otp);
        delayQueue.offer(new DelayCacheItemDTO(email, 90));
    }

    public String get(String email) {
        return this.cacheMap.get(email);
    }

    public void remove(String email) {
        this.cacheMap.remove(email);
    }
}

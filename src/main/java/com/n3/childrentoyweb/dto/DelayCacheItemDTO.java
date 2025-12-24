package com.n3.childrentoyweb.dto;

import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

public class DelayCacheItemDTO implements Delayed {
    private final String key;
    private final long expiryTime;

    public DelayCacheItemDTO(String key, long delayInSeconds) {
        this.key = key;
        this.expiryTime = System.currentTimeMillis() + (delayInSeconds * 1000);
    }

    public String getKey() {
        return key;
    }

    @Override
    public long getDelay(TimeUnit unit) {
        long diff = expiryTime - System.currentTimeMillis();
        return unit.convert(diff, TimeUnit.MILLISECONDS);
    }

    @Override
    public int compareTo(Delayed o) {
        return Long.compare(this.expiryTime, ((DelayCacheItemDTO) o).expiryTime);
    }
}

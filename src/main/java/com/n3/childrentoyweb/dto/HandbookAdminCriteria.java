package com.n3.childrentoyweb.dto;

import com.n3.childrentoyweb.utils.ValidatorUtil;

public class HandbookAdminCriteria extends  HandBookCriteria{
    public HandbookAdminCriteria(String keyword) {
        if(keyword == null || keyword.length() == 0){
            return;
        }

        if(ValidatorUtil.isNumber(keyword)){
            this.setId(Long.parseLong(keyword));
            return;
        }

        this.setTitle(keyword);
    }

    @Override
    public String toString() {
        return "HandbookAdminCriteria{} " + super.toString();
    }
}

package com.example.spring.security.services;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class ContractService {

    public Map<String, String> parseAdditionalOptions(String addOpt) {

        Map<String, String> mapAddOpt = new HashMap<>();

        if (addOpt.isEmpty()) {
            return mapAddOpt;
        }

        String[] additionalOptions = addOpt.split("; ");

        for (String o:
                additionalOptions) {
            String[] x = o.split(": ");
            mapAddOpt.put(x[0], x[1]);
        }

        return mapAddOpt;
    }

}

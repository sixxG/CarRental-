package com.example.spring.security.services;

import com.example.spring.security.models.Car;
import com.example.spring.security.repositories.CarRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class CarService {

    @Value("${upload.path}")
    private String uploadPath;
    @Autowired
    private CarRepository carRepository;

    public boolean addCar(Car car, MultipartFile file) throws IOException {

        if (file != null && !file.getOriginalFilename().isEmpty()) {
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String uuidFile = UUID.randomUUID().toString();
            String resultFileName = uuidFile + "." + file.getOriginalFilename();

            file.transferTo(new File(uploadPath + "/" + resultFileName));

            car.setImage(resultFileName);
        }

        carRepository.save(car);

        if (carRepository.findById(car.getId()) == null) {
            return false;
        }
        return true;
    }
}

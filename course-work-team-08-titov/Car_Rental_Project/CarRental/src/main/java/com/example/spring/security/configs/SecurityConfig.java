package com.example.spring.security.configs;

import com.example.spring.security.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

    //extends WebSecurityConfigurerAdapter
    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/").permitAll()
                .antMatchers("/only_for_admins/**").hasRole("ADMIN")
                .and()
                    .formLogin()
                    .loginPage("/login")
                    .permitAll()
                .and()
                    .logout()
                    //.logoutSuccessUrl("/login")
                    .permitAll();
//                   .csrf().disable();
    }

    //Создаём пользователей в памяти
//    @Bean
//    public UserDetailsService users() {
//        UserDetails user = User.builder()
//                .username("user")
//                .password("{bcrypt}$2a$12$CjcDWIS9ZYYI4Evo2n2gP.kbj.mNlAnmArrwj/sm7acCdlMtZk8vq")
//                .roles("USER")
//                .build();
//
//        UserDetails admin = User.builder()
//                .username("admin")
//                .password("{bcrypt}$2a$12$CjcDWIS9ZYYI4Evo2n2gP.kbj.mNlAnmArrwj/sm7acCdlMtZk8vq")
//                .roles("ADMIN","USER")
//                .build();
//
//        return new InMemoryUserDetailsManager(user, admin);
//    }


// jdbcAuthentication
//    @Bean
//    public JdbcUserDetailsManager users(DataSource dataSource) {
//        UserDetails user = User.builder()
//            .username("user")
//            .password("{bcrypt}$2a$12$CjcDWIS9ZYYI4Evo2n2gP.kbj.mNlAnmArrwj/sm7acCdlMtZk8vq")
//            .roles("USER")
//            .build();
//
//        UserDetails admin = User.builder()
//                .username("admin")
//                .password("{bcrypt}$2a$12$CjcDWIS9ZYYI4Evo2n2gP.kbj.mNlAnmArrwj/sm7acCdlMtZk8vq")
//                .roles("ADMIN","USER")
//                .build();
//
//        JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
//
//        if(users.userExists(user.getUsername())) {
//            users.deleteUser(user.getUsername());
//        }
//
//        if(users.userExists(admin.getUsername())) {
//            users.deleteUser(admin.getUsername());
//        }
//        users.createUser(user);
//        users.createUser(admin);
//
//        return users;
//    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();

        authenticationProvider.setPasswordEncoder(passwordEncoder());
        authenticationProvider.setUserDetailsService(userService);

        return authenticationProvider;
    }
}

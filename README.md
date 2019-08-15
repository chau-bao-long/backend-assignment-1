# Quick start
```bash
docker-compose build
docker-compose up
```
- Create & migrate db
```bash
docker-compose exec app rails db:create && rails db:migrate
```

- Seed user to test
```bash
docker-compose exec app rails db:seed
```

- Run test
```bash
docker-compose exec app rspec spec
```

### Available APIs
**GET**  /api/v1/hierarchy/staff                                                        
**GET**  /api/v1/hierarchy                                                              
**POST** /api/v1/hierarchy                                                              
**GET**  /api/v1/hierarchy/:id                                                          
**POST** /api/v1/sessions                                                               

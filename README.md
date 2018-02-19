## osquery Injection

Details: xxx

### How to deploy testcase?

```sh
git clone https://github.com/Om3rCitak/osquery-injection.git
```

```sh
cd osquery-injection/
```

```sh
docker-compose up
```

- Testcase: http://{docker_ip_address}:35275/?username=systemd-network
- Dev Version: http://{docker_ip_address}:35275/dev?q=select * from users;

---
2018 - [Omer Citak](https://omercitak.com/), [Netsparker](https://netsparker.com/)
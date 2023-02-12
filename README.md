# MetaWorldServer

meta-world-client를 위한 게임 네트워크 서버.

# 다중서버 환경 데이터 공유

같은 공간에서 유저들이 서로 다른 서버에 연결을 할 경우 Redis Pub/Sub를 사용하여 데이터 공유

<img src="https://user-images.githubusercontent.com/59630175/215166647-651488dd-6fb1-4751-bc7d-f16ebf2b7311.png" width="700" height="400"/>

- Redis Pub/Sub 적용 전
![redis적용하기전](https://user-images.githubusercontent.com/59630175/215166909-7ace93b2-83a5-4d22-801b-dd9c56b14df5.PNG)

- Redis Pub/Sub 적용 후
![redis 적용 후](https://user-images.githubusercontent.com/59630175/215166920-8ef7de36-ebf0-4c6a-9fc4-56b1fb770a63.PNG)

- Redis에서 채널을 구독 중인 클라이언트 수
![redis_cluster_elixir](https://user-images.githubusercontent.com/59630175/215166940-8ceef678-4063-49b2-ad77-42a59c5076d1.PNG)

To start your Phoenix server:
--
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

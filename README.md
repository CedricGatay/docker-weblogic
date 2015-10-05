
# docker-weblogic

- Requires JAVA 1.6 or newer
- Expects Fedora 21 o newer (64 bit)

## Info

- This Weblogic stack can be on a admin server node or cluster.
- After this image i will make other images for each domain model for developer

## Setup and use with source code

      $ git clone https://github.com/jefersonbsa/docker-weblogic.git
      $ cd docker-weblogic
      $ docker build -t docker-weblogic .
      $ docker run -it docker-weblogic bash

## Setup and use with dockerhub

	  $ docker pull jefersonbsa/docker-weblogic
	  $ docker run -it jefersonbsa/docker-weblogic bash

## Contributing

1. Fork it ( https://github.com/jefersonbsa/docker-weblogic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

docker-weblogic is released under the [MIT license](https://github.com/jefersonbsa/docker-weblogic/blob/master/LICENSE)
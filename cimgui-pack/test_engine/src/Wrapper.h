#include "jlcxx/jlcxx.hpp"

struct Wrapper{
  Wrapper(jlcxx::Module& module): module_(module) {};
  virtual ~Wrapper() {};
  virtual void add_methods() const = 0;

protected:
  jlcxx::Module& module_;
};

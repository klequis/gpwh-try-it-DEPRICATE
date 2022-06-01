data Box a = Box a deriving Show

instance Functor Box where
  fmap func (Box val) = Box (func val)


morePresents :: Box a -> Box [a]
morePresents (Box a) = Box [a]




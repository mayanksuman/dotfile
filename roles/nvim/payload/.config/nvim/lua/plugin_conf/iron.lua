local function config()
    local iron = require('iron')
    
    iron.core.add_repl_definitions {
      cpp =  {
        cling = {
          command = {'cling', '-std=c++17'}
        }
      },
      lua = {
        croissant = {
          command = {'croissant'}
        }
      },
      fennel = {
        fennel = {
          command = {'fennel'}
        }
      }
    }
    
    iron.core.set_config {
      preferred = {
        python  = 'ipython',
        haskell = 'intero',
        lisp    = 'sbcl',
        ocaml   = 'utop',
        scheme  = 'csi',
        lua     = 'croissant'
      }
    }
end

return {config=config}

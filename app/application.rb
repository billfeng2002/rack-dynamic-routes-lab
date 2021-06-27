class Application
    @@items=[]
    def call(env)
        resp=Rack::Response.new
        req=Rack::Request.new(env)
        path=req.path
        #resp.write(path)
        if(path.match(/\A\/items\//))
            item_name=path[7..]
            if(item=findItem(item_name))
                resp.write(item.price)
            else
                resp.status=400
                resp.write("Item not found")
            end
        else
            resp.status=404
            resp.write "Route not found."
        end
        resp.finish
    end

    def findItem(name)
        @@items.find{|item| item.name==name}
    end
end
Parse.Cloud.define("updateBalance", function(request, response) {
  const query1 = new Parse.Query("transaction");
  query1.equalTo("accountHolder", request.params.accountHolder);
  const query2 = new Parse.Query("transaction");
  query2.equalTo("recordedOnBalance", false);
  var mainQuery = new Parse.Query.and(query2,query1);
  mainQuery.find({
    success: function(results){
      let sum = 0;
      for (let i = 0; i < results.length; ++i) {
        if (results[i].get("credit") == true){
          sum += results[i].get("amount");
        }
        else{
          sum -= results[i].get("amount");
        }
        //results[i].set("recordedOnBalance", true);
      }
      //return the balance modifier
      response.success(sum);
    },
    error: function(error){

      response.error("transaction lookup failed");
    }
  });
});

Parse.Cloud.define("balance", function(request, response) {
  const query1 = new Parse.Query("transaction");
  query1.equalTo("accountHolder", request.params.accountHolder);
  query1.find({
    success: function(results){
      let sum = 0;
      for (let i = 0; i < results.length; ++i) {
        if (results[i].get("credit") == true){
          sum += results[i].get("amount");
        }
        else{
          sum -= results[i].get("amount");
        }
        //results[i].set("recordedOnBalance", true);
      }
      //return the balance modifier
      response.success(sum);
    },
    error: function(error){

      response.error("transaction lookup failed");
    }
  });
});

Parse.Cloud.define("test", (request, response) => {
  const query1 = new Parse.Query("TestObject");
  //query1.equalTo("accountHolder", request.params.accountHolder);
  query1.find().then((results) => {
      response.success(results);
      
  });
  catch(() => {
    response.error("there was an error on test cloud code");
  });
});




//
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello code got back to you");
});
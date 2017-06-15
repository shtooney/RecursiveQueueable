// This is a server-driven approach to continuously send API calls (& passes incremented variable each time to API call methods)

public class FireItUp implements Queueable{
    
    private Integer i;
    public FireItUp(Integer i){
        this.i = i;
    }
    
    public void execute(QueueableContext context) {
        
        // How many seconds will pass between each call - can be simply specified in the class constructor above vs hardcorded
        // 1000 milliseconds equate to 1 second
        Long milliSeconds = 7000;
        Long timeDiff = 0;
        
        // This let's time (specified above) pass before proceeding to do a chained job
        DateTime firstTime = System.now();
        do{
            timeDiff = System.now().getTime() - firstTime.getTime();
        }
        while(timeDiff <= milliSeconds);
        
        // When job stops at 10th iteration in this example - number can be simply specified in the class constructor above vs hardcorded
        if (i == 10) {
            // fireMyAPI is a method with a web service call. It fires the final API - passes a variable for example-sake
            MyAPIclass.fireMyAPI(i);
        } else  {
            // Fires the API and then chains a new enqueueJob (and passes + increments the variable)
            MyAPIclass.fireMyAPI(i);
            System.enqueueJob(new FireItUp(i + 1));
        }
        
    }    
}

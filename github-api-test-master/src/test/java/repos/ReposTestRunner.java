package repos;

import com.intuit.karate.junit4.Karate;
import cucumber.api.CucumberOptions;
import org.junit.runner.RunWith;

@CucumberOptions(tags = {"~@ignore", "@jay_test"})

@RunWith(Karate.class)
public class ReposTestRunner {

}
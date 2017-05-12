import java.utils.Scanner;

/**
 * Test class to evaluate terminal color themes that
 * are being customized.
 *
 * @author  Tyler Hostager
 * @version test
 */
public class Test {
    
    /* YEAHHH */
    private String testStr = "test string!!";
    private boolean runProgram = true;

    /**
     * Main method executes the program
     *
     * @param args  The arguments taken in to run the application
     */
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        char yes = "Y", no = "N";
        boolean validInput = false;

        while (runProgram) {
            System.out.println("Enter something in: ");
            String userInput = Scanner.nextLine();

            for (char ch : userInput.toString().toCharArray()) {
                System.out.println(ch);
            }

            while (validInput == false) {
                System.out.println("Continue program? (y/n): ");
                String userInput = Scanner.nextLine();
                char[] inputChars = userInput.toUpperCase().toCharArray();

                if (userInput != null && inputChars.length > 0 && inputChars.length < 2) {
                    char decChar = inputChars[0] == null ? N : inputChars[0];
                    switch (decChar) {
                        case yes:
                            validInput = true;
                            runProgram = true;
                            break;
                        case no:
                            validInput = true;
                            runProgram = false;
                            break;
                        default:
                            validInput = false;
                            System.out.println("Error: Invalid input.\nPlease try again.");
                            runProgram = true;
                            break;
                    }
                }
            }
        }

        exitProgram();
    }


    private static void exitProgram() {
        System.out.println("Exiting program.");
        System.exit(0);
    }
}




<?php

namespace Lasso\VmailBundle\Command;

use Doctrine\Common\Util\Debug;
use Lasso\VmailBundle\Repository\MailboxRepository;
use Symfony\Bundle\FrameworkBundle\Command\ContainerAwareCommand;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Class ListMailboxesCommand
 *
 * @package Lasso\VmailBundle\Command
 */
class ListMailboxesCommand extends ContainerAwareCommand
{

    /**
     * Configuration
     */
    protected function configure()
    {
        $this
            ->setName('lasso:vmail:list-mailboxes')
            ->setDescription('returns a list of mailboxes')
            ->addArgument('username', InputArgument::OPTIONAL, 'mailbox search string');
    }

    /**
     * @param InputInterface  $input
     * @param OutputInterface $output
     *
     * @return mixed
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        /** @var $mailboxRepository MailboxRepository */
        $mailboxRepository = $this->getContainer()->get('lasso_vmail.mailbox_repository');
        $mailboxes         = $mailboxRepository->findAll($input->getArgument('username'));

        foreach ($mailboxes as $mailbox) {
            $output->writeln($mailbox->getUsername());
        }
    }
}
